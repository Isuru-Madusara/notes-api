# Notes API

![CI/CD](https://github.com/Isuru-Madusara/notes-api/actions/workflows/ci.yml/badge.svg?branch=main)

A small FastAPI notes service used to practise a full DevOps pipeline:
GitHub Actions, Docker, Terraform and AWS.

## Pipeline

push -> lint -> tests -> Docker build + Trivy scan -> push image to ECR -> deploy to EC2 (via SSM)

## Endpoints

- GET /health
- GET /notes
- POST /notes

## Infrastructure

Terraform manages ECR, EC2, IAM (including GitHub OIDC) and CloudWatch Logs.
Terraform state is stored in S3. No long-lived AWS keys are used anywhere.
