terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.17.0"
    }
  }
}

provider "google" {
    credentials = file("./Keys/mykey.json")
  project     = "lofty-hybrid-448518-c8"
  region      = "us-central1"
}

resource "google_storage_bucket" "auto-expire" {
  name          = "lofty-hybrid-448518-c8"
  location      = "US"
  force_destroy = true


}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "example_dataset"
}