# CRM System with Contact Merge & Custom Fields

A Laravel-based **Contact Management CRM** that supports Contact CRUD, Custom Fields, File Uploads, and an advanced **Merge Contacts** feature — built with AJAX for a seamless user experience.

---

## 🚀 Features

### ✅ Contact Management (CRUD)
- Add, Edit, View, and Delete Contacts
- Upload Profile Image & Additional Document
- AJAX-based Create, Update & Delete (No page reload)

### 🧩 Custom Fields Module
- Add unlimited custom fields dynamically (Text, Number, Date, Select, etc.)
- Custom fields auto-appear in Contact Form
- Stores custom field values per contact
- Custom fields also merge during contact merge

### 🔍 Search & Filters
- Search by **Name, Email, Gender**
- Real-time AJAX based filtering

### 🔗 Merge Contacts Feature
- Select multiple contacts and merge into one
- Choose “Master Contact” during merge
- Secondary contact data is **not deleted**
- Merge includes:
  - Emails
  - Phone numbers
  - Custom Field Values
  - Additional contact details
- Secondary contact is marked as **Merged**

---

## 🛠️ Tech Stack

| Component | Technology |
|-----------|-------------|
| Backend | Laravel 8.x (PHP 7.4) |
| Frontend | Blade, jQuery, Bootstrap |
| Database | MySQL |
| AJAX | jQuery AJAX |
| Storage | Laravel Filesystem |

---

## 📂 Project Structure

app/
├── Models/
│ ├── Contact.php
│ ├── ContactEmail.php
│ ├── ContactPhone.php
│ ├── CustomFieldDefinition.php
│ └── CustomFieldValue.php
├── Http/Controllers/
│ ├── ContactController.php
│ └── CustomFieldDefinitionController.php

resources/views/
├── contacts/
├── custom-fields/
└── layouts/

db_new/
|___ intricare_dbs.sql


public/uploads/
routes/web.php



---

## ⚙️ Installation

```bash
git clone https://github.com/jitendrav516/crud_implement.git
cd repo-name

composer install
cp .env.example .env
php artisan key:generate

# Create database and update DB credentials in .env

php artisan migrate
php artisan serve
