project_name: "block-fivetran-netsuite-spreedly"

################ Constants ################

constant: CONFIG_PROJECT_NAME {
  value: "block-fivetran-netsuite-config-spreedly"
  export: none
}

constant: CONNECTION_NAME {
  value: "snowflake"
  export: override_required
}

constant: SCHEMA_NAME {
  value: "netsuite"
  export: override_required
}

################ Dependencies ################

# local_dependency: {
#   project: "@{CONFIG_PROJECT_NAME}"

#   override_constant: SCHEMA_NAME {
#     value: "@{SCHEMA_NAME}"
#   }
# }
