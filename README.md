# Apigee & Application Integration Kafka Webhook

[![PyPI status](https://img.shields.io/pypi/status/ansicolortags.svg)](https://pypi.python.org/pypi/ansicolortags/) 

**This is not an official Google product.**<BR>This implementation is not an official Google product, nor is it part of an official Google product. Support is available on a best-effort basis via GitHub.

***

## Work in progress...


This repository provides a solution for integrating GitHub webhook events with a Kafka topic via Google Apigee and Google Cloud Application Integration. 

It allows you to securely receive webhook notifications from GitHub and seamlessly forward them to Kafka for further processing or analysis.

## Use Case: GitHub Webhook

This integration focuses on handling GitHub webhook events. It enables you to capture events like:

* **Push:** Code pushes to a repository.
* **Pull Request:** Creation, updates, and merges of pull requests.
* **Issues:** Creation, modification, and closure of issues.
* **And more:**  A wide range of other GitHub events.

These events are securely received by an Apigee endpoint and then relayed to a Kafka topic.

## Architecture

The integration follows this flow:

[GitHub] --> [Apigee Webhook Endpoint] --> [Application Integration] --> [Kafka Connector] --> [Kafka Topic]


## Components

* **Apigee:**  Acts as the secure entry point for GitHub webhooks, providing authentication and authorization.
* **Application Integration:** Google Cloud's service for connecting to various backend systems, including Kafka.
* **Integration Connector:** Enables Application Integration to publish messages to a Kafka topic.
* **Kafka Topic:** The destination where GitHub events are stored for consumption. Hosted in your Kafka server.


## Code Structure

* `apiproxy/`:  Contains the Apigee proxy configuration (proxies, policies, resources).
* `integration/`:  Holds the Application Integration configuration files.
* `install.sh/`:  Scripts for deployment of proxy and integration.


## Setup and Configuration

### 1. Apigee
* **Create an API proxy:**  Configure it to accept `POST` requests from GitHub.
* **Secure the proxy:** Implement API keys, OAuth, or other authentication mechanisms.
* **Validate webhook payloads:**  Use policies (e.g., HMAC verification) to ensure the integrity of incoming data.
* **Transform data (optional):**  Use policies to extract or modify data within the payload before sending it to Application Integration.

### 2. Application Integration
* **Create an integration:** Configure it to receive data from the Apigee proxy.
* **Map data:** Define how to transform the GitHub webhook payload to match the desired format for Kafka.

### 3. Integration Connector
* **Configure the connector:** Provide Kafka broker address, topic name, authentication details, and other necessary settings.

### 4. GitHub
* **Create a webhook:** In your GitHub repository settings, add a new webhook.
* **Set the Payload URL:** Point it to your secured Apigee endpoint.
* **Select events:** Choose the specific events you want to receive.
* **Content type:** Set to `application/json`.
* **Secret (optional):**  Configure a secret for HMAC verification to enhance security.


