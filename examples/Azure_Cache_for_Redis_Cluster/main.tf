module "redis" {
  source  = "connectgeeks/azure-cache-for-redis/azurerm"
  version = "3.0.0"

  # By default, this module will create a resource group
  # proivde a name to use an existing resource group and set the argument 
  # to `create_resource_group = false` if you want to existing resoruce group. 
  # If you use existing resrouce group location will be the same as existing RG.
  create_resource_group = false
  resource_group_name   = "connectgeeks-develop-73h82-rg"
  location              = "southcentralus"

  # Configuration to provision a Standard Redis Cache
  # Specify `shard_count` to create on the Redis Cluster
  # Add patch_schedle to this object to enable redis patching schedule
  redis_server_settings = {
    demoredischache-sharedcluster = {
      sku_name    = "Premium"
      capacity    = 2
      shard_count = 3
    }
  }

  # MEMORY MANAGEMENT
  # Azure Cache for Redis instances are configured with the following default Redis configuration values:
  redis_configuration = {
    maxmemory_reserved = 2
    maxmemory_delta    = 2
    maxmemory_policy   = "allkeys-lru"
  }

  # Azure Cache for Redis firewall filter rules are used to provide specific source IP access. 
  # Azure Redis Cache access is determined based on start and end IP address range specified. 
  # As a rule, only specific IP addresses should be granted access, and all others denied.
  # "name" (ex. azure_to_azure or desktop_ip) may only contain alphanumeric characters and underscores
  firewall_rules = {
    access_to_azure = {
      start_ip = "1.2.3.4"
      end_ip   = "1.2.3.4"
    },
    desktop_ip = {
      start_ip = "49.204.228.223"
      end_ip   = "49.204.228.223"
    }
  }

  # (Optional) To enable Azure Monitoring for Azure Cache for Redis
  # (Optional) Specify `storage_account_name` to save monitoring logs to storage. 
  # log_analytics_workspace_name = "loganalytics-we-sharedtest2"

  # Tags for Azure Resources
  tags = {
    Terraform   = "true"
    Environment = "development"
    Owner       = "connectgeeks"
    URL         = "https://github.com/connectgeeks"
  }
}
