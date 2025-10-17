# Laravel Task Repository

A Laravel PHP web application with Docker and Kubernetes support.

## About

This repository contains a Laravel-based web application that uses:

- Laravel PHP framework
- SQLite database
- Docker containerization
- Helm charts for Kubernetes deployment

The project follows the standard Laravel structure with Models, Controllers, and Routes.

## Running Locally

### Prerequisites

- PHP 8.4
- Composer
- Docker (optional)
- Kubernetes/Helm (optional)

### Option 1: Standard PHP Setup

```bash
git clone git@github.com:krzysztofhaczela/php-task.git
cd php-task

composer install

cp .env.example .env
php artisan key:generate

php artisan migrate

php artisan serve
```
The application will be available at http://localhost:8000/

### Option 2: Docker Setup

```bash
docker build -t laravel-task .
docker run -p 8080:8080 laravel-task
```
The application will be available at http://localhost:8080/
