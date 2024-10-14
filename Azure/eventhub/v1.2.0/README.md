## Attributes:

- eventhub_name                                = string #(Required) Specifies the name of the EventHub resource. Changing this forces a new resource to be created.

- eventhub_namespace_name                      = string #(Required) Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.

- eventhub_resource_group_name                 = string #(Required) The name of the resource group in which the EventHub's parent Namespace exists. Changing this forces a new resource to be created.

- eventhub_partition_count                     = number #(Required) Partition_count cannot be changed unless Eventhub Namespace SKU is Premium.

- eventhub_message_retention                   = number #(Required) When using a dedicated Event Hubs cluster, maximum value of message_retention is 90 days. When using a shared parent EventHub Namespace, maximum value is 7 days; or 1 day when using a Basic SKU for the shared parent EventHub Namespace.

- eventhub_status                              = string #(Optional) Specifies the status of the Event Hub resource. Possible values are Active, Disabled and SendDisabled. Defaults to Active

- eventhub_storage_blob_storage_account_name   = string #(Optional) The ID of the Blob Storage Account where messages should be archived
eventhub_storage_blob_storage_container_name = string #(Optional) The name of the Container within the Blob Storage Account where messages should be archived.

- eventhub_storage_blob_storage_account_resource_group_name = string #(Required) Specifies the name of the resource group the Storage Account is located in.

- eventhub_capture_description = list(object({          #(Optional)A capture_description block supports the following

    - capture_description_enabled             = bool      #(Required)Specifies if the Capture Description is Enabled.

    - capture_description_encoding            = string    #(Required)Specifies the Encoding used for the Capture Description. Possible values are Avro and AvroDeflate.

    - capture_description_interval_in_seconds = number    #(Optional)Specifies the time interval in seconds at which the capture will happen. Values can be between 60 and 900 seconds. Defaults to 300 seconds.
    
    - capture_description_size_limit_in_bytes = number    #(Optional)Value should be between 10485760 and 524288000 bytes. Defaults to 314572800 bytes.
    
    - capture_description_skip_empty_archives = bool      #(Optional)Specifies if empty files should not be emitted if no events occur during the Capture time window. Defaults to false.
    
    - capture_description_destination = list(object({
    
        - capture_description_destination_name                = string #(Required)At this time the only supported value is EventHubArchive.AzureBlockBlob.
    
        - capture_description_destination_archive_name_format = string #The Blob naming convention for archiving. e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
    
        - capture_description_destination_blob_container_name = string #(Required) The name of the Container within the Blob Storage Account where messages should be archived.
        
        - capture_description_destination_storage_account_id = sting #(Required) The ID of the Blob Storage Account where messages should be archived.

>## Notes:

>1. eventhub_partition_count cannot be changed unless Eventhub Namespace SKU is Premium.

>2. When using a dedicated Event Hubs cluster, maximum value of eventhub_partition_count is 1024. When using a shared parent EventHub Namespace, maximum value is 32.

>3. When using a dedicated Event Hubs cluster, maximum value of eventhub_message_retention is 90 days. When using a shared parent EventHub Namespace, maximum value is 7 days; or 1 day when using a Basic SKU for the shared parent EventHub Namespace.

>4. At this time it's only possible to Capture EventHub messages to Blob Storage. There's a Feature Request for the Azure SDK to add support for Capturing messages to Azure Data Lake here.