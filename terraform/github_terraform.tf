# ---------- PLAN role: pull requests, read-only ----------
data "aws_iam_policy_document" "tf_plan_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repo_sub}:pull_request"]
    }
  }
}

resource "aws_iam_role" "tf_plan" {
  name               = "notes-api-tf-plan-role"
  assume_role_policy = data.aws_iam_policy_document.tf_plan_assume.json
}

resource "aws_iam_role_policy_attachment" "tf_plan_readonly" {
  role       = aws_iam_role.tf_plan.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

data "aws_iam_policy_document" "tf_plan_lock" {
  statement {
    sid       = "StateLockFileOnly"
    actions   = ["s3:PutObject", "s3:DeleteObject"]
    resources = ["arn:aws:s3:::${var.state_bucket}/notes-api/terraform.tfstate.tflock"]
  }
}

resource "aws_iam_role_policy" "tf_plan_lock" {
  name   = "state-lock-only"
  role   = aws_iam_role.tf_plan.id
  policy = data.aws_iam_policy_document.tf_plan_lock.json
}

# ---------- APPLY role: main branch + production environment ----------
data "aws_iam_policy_document" "tf_apply_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repo_sub}:environment:production"]
    }
  }
}

resource "aws_iam_role" "tf_apply" {
  name               = "notes-api-tf-apply-role"
  assume_role_policy = data.aws_iam_policy_document.tf_apply_assume.json
}

resource "aws_iam_role_policy_attachment" "tf_apply_admin" {
  role       = aws_iam_role.tf_apply.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
