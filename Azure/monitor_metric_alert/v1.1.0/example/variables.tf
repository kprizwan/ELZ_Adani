#Variable Definition for Metric Alerts
variable "monitor_metric_alert_variables" {
  type = map(object({
    metric_alert_name                = string
    metric_alert_resource_group_name = string
    scopes = map(object({
      scope_name                = string
      scope_resource_group_name = string
      }
    ))
    enabled                  = bool
    auto_mitigate            = bool
    description              = string
    frequency                = string
    severity                 = number
    target_resource_type     = string
    target_resource_location = string
    window_size              = string
    tags                     = map(string)
    action = map(object({
      action_group = object({
        action_group_name                = string
        action_group_resource_group_name = string
        action_group_subscription_id     = string
      })
      webhook_properties = map(string)
    }))
    criteria = map(object({
      metric_namespace = string
      metric_name      = string
      aggregation      = string
      operator         = string
      threshold        = string
      dimension = map(object({
        dimension_name     = string
        dimension_operator = string
        dimension_values   = list(string)
      }))
      skip_metric_validation = bool
    }))
    dynamic_criteria = object({
      metric_namespace  = string
      metric_name       = string
      aggregation       = string
      operator          = string
      alert_sensitivity = string
      dimension = map(object({
        dimension_name     = string
        dimension_operator = string
        dimension_values   = list(string)
      }))
      evaluation_total_count   = number
      evaluation_failure_count = number
      ignore_data_before       = string
      skip_metric_validation   = bool
    })
    application_insights_web_test_location_availability_criteria = object({
      web_test_id           = string
      component_id          = string
      failed_location_count = string
    })
  }))
  default     = {}
  description = "alert plans"
}
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

variable "monitor_action_group_variables" {
  type = map(object({
    name                = string
    resource_group_name = string
    short_name          = string
    enabled             = bool
    arm_role_receiver = map(object({
      name                    = string
      role_id                 = string
      use_common_alert_schema = bool
    }))
    automation_runbook_receiver = map(object({
      name                                   = string
      account_name                           = string
      automation_runbook_subscription_id     = string
      automation_runbook_resource_group_name = string
      runbook_name                           = string
      webhook_resource_id                    = string
      is_global_runbook                      = bool
      service_uri                            = string
      use_common_alert_schema                = bool
    }))
    azure_app_push_receiver = map(object({
      name          = string
      email_address = string
    }))
    azure_function_receiver = map(object({
      name                               = string
      azure_function_resource_group_name = string
      function_app_name                  = string
      azure_function_subscription_id     = string
      function_name                      = string
      http_trigger_uri                   = string
      use_common_alert_schema            = bool
    }))
    email_receiver = map(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = bool
    }))
    event_hub_receiver = map(object({
      name                          = string
      eventhub_name                 = string
      namespace                     = string
      event_hub_resource_group_name = string
      event_hub_subscription_id     = string
      tenant_id                     = string
      use_common_alert_schema       = bool
    }))
    itsm_receiver = map(object({
      name                     = string
      workspace_name           = string
      itsm_resource_group_name = string
      itsm_subscription_id     = string
      connection_id            = string
      ticket_configuration     = string
      region                   = string
    }))
    logic_app_receiver = map(object({
      name                          = string
      logic_app_subscription_id     = string
      logic_app_resource_group_name = string
      workflow_name                 = string
      callback_uri                  = string
      use_common_alert_schema       = string
    }))
    sms_receiver = map(object({
      name         = string
      country_code = string
      phone_number = string
    }))
    voice_receiver = map(object({
      name         = string
      country_code = string
      phone_number = string
    }))
    webhook_receiver = map(object({
      name                    = string
      service_uri             = string
      use_common_alert_schema = bool
      aad_auth = object({
        object_id      = string
        identifier_uri = string
        tenant_id      = string
      })
    }))
    tags = map(string)

  }))
  default = {}
}

variable "storage_account_variables" {
  type = map(object({
    name                              = string
    resource_group_name               = string
    location                          = string
    account_tier                      = string
    account_replication_type          = string
    account_kind                      = string
    access_tier                       = string
    enable_https_traffic_only         = bool
    min_tls_version                   = string
    allow_nested_items_to_be_public   = bool
    large_file_share_enabled          = bool
    nfsv3_enabled                     = bool
    is_hns_enabled                    = bool
    cross_tenant_replication_enabled  = bool
    shared_access_key_enabled         = bool
    edge_zone                         = string
    infrastructure_encryption_enabled = bool
    queue_encryption_key_type         = string
    table_encryption_key_type         = string


    custom_domain = list(object({
      name          = string
      use_subdomain = bool
    }))

    identity = list(object({
      type         = string
      identity_ids = list(string)
    }))

    routing = list(object({
      publish_internet_endpoints  = bool
      publish_microsoft_endpoints = bool
      choice                      = string
    }))
    azure_files_authentication = list(object({
      directory_type = string
      active_directory = object({
        storage_sid         = string
        domain_name         = string
        domain_sid          = string
        domain_guid         = string
        forest_name         = string
        netbios_domain_name = string
      })
    }))

    customer_managed_key = list(object({
      key_vault_key_id          = string
      user_assigned_identity_id = string
    }))

    share_properties = list(object({
      retention_policy = object({
        days = number
      })
      cors_rule = list(object({
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
      smb = list(object({
        versions                        = list(string)
        authentication_types            = list(string)
        kerberos_ticket_encryption_type = list(string)
        channel_encryption_type         = list(string)
      }))
    }))

    queue_properties = list(object({
      logging = object({
        delete                = bool
        read                  = bool
        version               = string
        write                 = bool
        retention_policy_days = string
      })
      hour_metrics = object({
        enabled               = bool
        include_apis          = bool
        retention_policy_days = string
        version               = string
      })
      minute_metrics = object({
        enabled               = bool
        include_apis          = bool
        retention_policy_days = string
        version               = string
      })
      cors_rule = list(object({
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
    }))

    network_rules = list(object({
      default_action = string
      bypass         = list(string)
      ip_rules       = list(string)
      private_link_access = object({
        endpoint_resource_id = string
        endpoint_tenant_id   = string
      })
    }))

    storage_account_tags = map(string)
    blob_properties = list(object({
      enable_versioning        = bool
      last_access_time_enabled = bool
      change_feed_enabled      = bool
      default_service_version  = string
      delete_retention_policy = object({
        blob_retention_policy = string
      })
      container_delete_retention_policy = object({
        container_delete_retention_policy = string
      })
      cors_rule = list(object({
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
    }))
    static_website = object({
      index_path      = string
      custom_404_path = string
    })
  }))
}
