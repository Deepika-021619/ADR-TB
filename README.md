ADR-TB

Adverse Drug Reaction Reporting and Monitoring Platform for Tuberculosis

ADR-TB is a web-based application developed to support structured
reporting, assessment, and monitoring of adverse drug reactions (ADRs)
associated with tuberculosis (TB) treatment.

The platform provides a guided reporting workflow, organ-system-based
symptom assessment, automated severity grading, causality assessment,
and structured ADR report generation.

Overview

ADR-TB was designed to provide a structured digital workflow for:

Patient and reporter information capture

TB clinical and treatment information

TB regimen and suspected-drug documentation

Organ-system-based ADR assessment

Severity grading using CTCAE

Causality assessment using the WHO-UMC system

Automated ADR report generation

Structured storage of submitted records

Key Features

Structured ADR Reporting

Guided questionnaires support systematic documentation of suspected
adverse drug reactions during TB treatment.

Dynamic Questionnaires

The interface supports conditional questions, dynamic field
activation/deactivation, input validation, Save and Next navigation,
required-field validation, and confirmation messages.

Severity Grading

The application incorporates the Common Terminology Criteria for Adverse
Events (CTCAE) framework for ADR severity grading.

Causality Assessment

The application incorporates the WHO-Uppsala Monitoring Centre (WHO-UMC)
system for causality assessment.

Automated Reports

The platform generates structured ADR reports containing relevant
patient, treatment, symptom, severity, and causality information.

Role-Based Workflow

The application supports workflows for different user roles, including
physician/clinician, patient, and institutional/research users.

Cross-Platform Frontend

The frontend was developed using Flutter to provide a responsive
interface across supported platforms.

System Architecture

                  +----------------------+
                  |     Flutter Web      |
                  |      Frontend       |
                  +----------+-----------+
                             |
                       RESTful APIs
                       HTTP / JSON
                             |
                             v
                  +----------------------+
                  |       FastAPI        |
                  |       Backend        |
                  +----------+-----------+
                             |
                             v
                  +----------------------+
                  |        MySQL         |
                  |       Database       |
                  +----------------------+

Frontend

Flutter

Dart

Flutter Web

HTTP/REST API communication

Backend

Python

FastAPI

RESTful APIs

JSON

Validation

The application underwent technical and end-user validation.

Technical Validation

Scientists evaluated six usability parameters:

Ease of access through QR code

Loading speed

Interface usability

Ease of form completion

Data-entry responsiveness

Device compatibility

End-User Validation

Clinicians evaluated:

Clinical relevance of the ADR questionnaire

Completeness of symptom coverage

Appropriateness of CTCAE severity grading

Appropriateness of WHO-UMC causality assessment

Clinical usefulness of generated ADR reports

Potential integration into routine TB care

Database

MySQL 
