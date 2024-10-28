#Variables for metric alerts
monitor_metric_alert_variables = {
  "alert1" = {
    action = {
      "action_group" = {
        action_group = {
          action_group_name                = "ploceusag000001"
          action_group_resource_group_name = "ploceusrg000001"
          action_group_subscription_id     = "7877d8aa-c51f-4741-b864-e77ef88cd435"
        }
        webhook_properties = null
      }
    }
    application_insights_web_test_location_availability_criteria = null
    auto_mitigate                                                = true
    criteria = {
      #When the alert rule contains multiple criteria, the use of dimensions is limited to one value per dimension within each criterion.
      "availability" = {
        aggregation = "Average"
        dimension = {
          "d1" = {
            dimension_name     = "ApiName"
            dimension_operator = "Include"
            dimension_values   = ["*"]
          }
          "d2" = {
            dimension_name     = "GeoType"
            dimension_operator = "StartsWith"
            dimension_values   = ["Primary"]
          }
        }
        metric_name            = "Availability"
        metric_namespace       = "Microsoft.Storage/storageAccounts"
        operator               = "LessThan"
        skip_metric_validation = false
        threshold              = 5
      }
    }
    description                      = "Storage Transaction Alert"
    dynamic_criteria                 = null
    enabled                          = false
    frequency                        = null
    metric_alert_name                = "ploceusma000001"
    metric_alert_resource_group_name = "ploceusrg000001"
    scopes = {
      "ploceusstg000001" = {
        scope_name                = "ploceusstg000001"
        scope_resource_group_name = "ploceusrg000001"
      }
      #Alerts are currently not supported with multi resource level
    }
    severity = 1
    tags = {
      "Created_By" = "Ploceus"
      "Department" = "CIS"
    }
    target_resource_location = "westus2"
    target_resource_type     = "Microsoft.Storage/storageAccounts"
    window_size              = null
  }
}
monitor_action_group_variables = {
  "action1" = {
    arm_role_receiver = {
      "monitoring_contributor" = {
        name                    = "Monitoring Contributor"
        role_id                 = "749f88d5-cbae-40b8-bcfc-e573ddc772fa"
        use_common_alert_schema = true
      }
      "monitoring_reader" = {
        name                    = "Monitoring Reader"
        role_id                 = "43d0d8ad-25c7-4714-9337-8ba259a9fe05"
        use_common_alert_schema = true
      }
    }
    automation_runbook_receiver = {}
    azure_app_push_receiver = {
      "ploceus" = {
        email_address = "xxxxxxxx_apppush@neudesic.com"
        name          = "xxxxxxxx_apppush"
      }
      "ploceus2" = {
        email_address = "xxxxxxxx_apppush2@neudesic.com"
        name          = "xxxxxxxx_apppush2"
      }
    }
    azure_function_receiver = {}
    email_receiver = {
      "ploceus" = {
        email_address           = "xxxxxxxx_email@neudesic.com"
        name                    = "xxxxxxxx_email"
        use_common_alert_schema = true
      }
      "ploceus2" = {
        email_address           = "xxxxxxxx_email2@neudesic.com"
        name                    = "xxxxxxxx_email2"
        use_common_alert_schema = true
      }
    }
    enabled             = false
    event_hub_receiver  = {}
    itsm_receiver       = {}
    logic_app_receiver  = {}
    name                = "ploceusag000001"
    resource_group_name = "ploceusrg000001"
    short_name          = "pag1"
    sms_receiver = {
      "key" = {
        name         = "remotesupport"
        country_code = "1"
        phone_number = "2027953213"
      }
      "key2" = {
        name         = "remotesupport2"
        country_code = "1"
        phone_number = "2027953214"
      }
    }
    tags = {
      "Created_By" = "Ploceus"
      Department   = "CIS"
    }
    voice_receiver = {
      "key" = {
        name         = "remotesupport_voice"
        country_code = "1"
        phone_number = "2027953213"
      }
      "key2" = {
        name         = "remotesupport_voice2"
        country_code = "1"
        phone_number = "2027953214"
      }
    }
    webhook_receiver = {}
  }
}
resource_group_variables = {
  "resource_group" = {
    name     = "ploceusrg000001"
    location = "westus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

storage_account_variables = {
  "ploceus_app_storage" = {
    access_tier                       = null
    account_kind                      = null
    account_replication_type          = "LRS"
    account_tier                      = "Standard"
    allow_nested_items_to_be_public   = null
    azure_files_authentication        = []
    blob_properties                   = []
    cross_tenant_replication_enabled  = null
    custom_domain                     = []
    customer_managed_key              = []
    edge_zone                         = null
    enable_https_traffic_only         = null
    identity                          = []
    infrastructure_encryption_enabled = null
    is_hns_enabled                    = null
    large_file_share_enabled          = null
    location                          = "westus2"
    min_tls_version                   = null
    name                              = "ploceusstg000001"
    network_rules                     = []
    nfsv3_enabled                     = null
    queue_encryption_key_type         = null
    queue_properties                  = []
    resource_group_name               = "ploceusrg000001"
    routing                           = []
    share_properties                  = []
    shared_access_key_enabled         = null
    static_website = {
      custom_404_path = null
      index_path      = null
    }
    storage_account_tags = {
      "Created_By" = "Ploceus"
      Department   = "CIS"
    }
    table_encryption_key_type = null
  }
}

storage_account_sub_subscription_id      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
storage_account_sub_tenant_id            = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
monitor_metric_alert_sub_subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
monitor_metric_alert_sub_tenant_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
action_group_subscription_id             = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
action_group_tenant_id                   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"