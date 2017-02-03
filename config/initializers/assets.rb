# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.40'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# @todo Shouldn't be necessary to add active_admin assets.
Rails.application.config.assets.precompile += %w(
  active_admin.css
  active_admin.js
  active_admin/application.js
  active_admin/print.css
  individual/jquery.min.js
  individual/jquery-ui.min.js
  individual/jquery.validationEngine-en.js
  individual/jquery.validationEngine-fr.js
  individual/jquery.validationEngine-uk.js
  individual/modernizr.min.js
  simulators/default_simulator.js
  simulators/deviation_simulator.js
  simulators/impact_simulator.js
  simulators/tax_simulator.js
  print.css
)
