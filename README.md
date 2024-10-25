**Ben Pavey's Website - benpavey.com**

Welcome to the repository for benpavey.com. This project is a personal website built using Django and hosted on Render. It includes a structured branching strategy for development and production environments, with automated workflows for deployment.

testing

**Table of Contents**

Project Overview

Tech Stack
Branching Strategy
Getting Started
Deployment
Contributing
License
Project Overview

A brief description of the project. This site serves as a personal portfolio and will be used to showcase various projects and skills.

**Tech Stack**

Framework: Django
Deployment: Render
CI/CD: GitHub Actions
Versioning: release-please (planned)
Branching Strategy

The project uses a structured branching strategy:

main: Production-ready branch.
development: Active development and testing branch.
Feature branches: Short-lived branches for new features and bug fixes, merged into development.

**Getting Started**

Prerequisites

Python 3.9+
Git

Setup

Clone the repository: git clone https://github.com/morethanatester/django-benpavey.git

cd django-benpavey

Create and activate a virtual environment:

python3 -m venv venv
source venv/bin/activate

Install the project dependencies: pip install -r requirements.txt

Run the Django development server:

python manage.py runserver


Deployment

The project is deployed to Render using separate environments for development and production.

Contributing

Contributions are welcome. Please open an issue or create a pull request with your changes.

License

This project is licensed under the MIT License - see the LICENSE file for details.
