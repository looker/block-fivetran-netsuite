include: "/views/*.view"
include: "*.view"

explore: transaction_lines {
  sql_always_where:
 (${accounting_periods.fiscal_calendar_id} is null
        or ${accounting_periods.fiscal_calendar_id}  = (select
                                                      fiscal_calendar_id
                                                    from @{SCHEMA_NAME}.subsidiaries
                                                    where parent_id is null)
  )
  ;;
  join: transactions {
    type: left_outer #TODO AJC This was actually listed as just "join" but i don't know the snowflake default
    sql_on: ${transactions.transaction_id} = ${transaction_lines.transaction_id}
    and not ${transactions._fivetran_deleted} ;;
    relationship: many_to_many #AJC TODO wise to check and see if transaction_id is also a pkey, but it isnt what is indicated right now
  }
  join: transactions_with_converted_amounts {
    type: left_outer
    sql_on: ${transaction_lines.transaction_line_id} = ${transactions_with_converted_amounts.transaction_line_id}
        and ${transaction_lines.transaction_id} = ${transactions_with_converted_amounts.transaction_id}
        and ${transactions_with_converted_amounts.reporting_accounting_period_id} = ${transactions_with_converted_amounts.transaction_accounting_period_id}
 ;;
relationship: many_to_many #TODO AJC Needs confirmation
  }
  join: accounts {
    type: left_outer
    sql_on: ${transaction_lines.account_id} = ${accounts.account_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: parent_account {
    from: accounts
    sql_on: ${accounts.parent_id} = ${parent_account.account_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: accounting_periods {
    type: left_outer
    sql_on: ${transactions.accounting_period_id} = ${accounting_periods.accounting_period_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: income_accounts {
    type: left_outer
    sql_on: ${accounts.account_id} = ${income_accounts.income_account_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: expense_accounts {
    type: left_outer
    sql_on: ${accounts.account_id} = ${expense_accounts.expense_account_id};;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: customers {
    type: left_outer
    sql_on: ${transaction_lines.company_id} = ${customers.customer_id}
        and not ${customers._fivetran_deleted} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: items {
    type: left_outer
    sql_on: ${transaction_lines.item_id} = ${items.item_id}
        and not ${items._fivetran_deleted} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: locations {
    type: left_outer
    sql_on: ${transaction_lines.location_id} = ${locations.location_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: vendors {
    type: left_outer
    sql_on: ${transaction_lines.company_id} = ${vendors.vendor_id}
        and not ${vendors._fivetran_deleted} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: vendor_types {
    type: left_outer
    sql_on: ${vendors.vendor_type_id} = ${vendor_types.vendor_type_id}
        and not ${vendor_types._fivetran_deleted} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: currencies {
    type: left_outer
    sql_on: ${transactions.currency_id} = ${currencies.currency_id}
        and not ${currencies._fivetran_deleted} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: departments {
    type: left_outer
    sql_on: ${transaction_lines.department_id} = ${departments.department_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: subsidiaries {
    type: left_outer
    sql_on: ${transaction_lines.subsidiary_id} = ${subsidiaries.subsidiary_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
}
