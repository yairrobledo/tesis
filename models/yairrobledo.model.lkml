# Define the database connection to be used for this model.
connection: "national_parks"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: yairrobledo_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: yairrobledo_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Yairrobledo"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: monthly_visits {
  label: "new"
}

explore: guides {}

explore: climbing {}

explore: park_noaa_stations {}

explore: detailed_weather {}

explore: park_climate {}

explore: detailed_climate {}

explore: detailed_visits {}

explore: parks {}

explore: trails {}

explore: park_species {}
