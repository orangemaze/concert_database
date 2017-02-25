# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( bootstrap.min.css )
Rails.application.config.assets.precompile += %w( metisMenu.min.css )
Rails.application.config.assets.precompile += %w( timeline.css )
Rails.application.config.assets.precompile += %w( sb-admin-2.css )
Rails.application.config.assets.precompile += %w( jquery-te-1.4.0.css )
Rails.application.config.assets.precompile += %w( jquery-ui-1.10.4.custom.css )

Rails.application.config.assets.precompile += %w( flags.css.scss )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( metisMenu.min.js )
Rails.application.config.assets.precompile += %w( sb-admin-2.js )
Rails.application.config.assets.precompile += %w( jquery-te-1.4.0.min.js )
Rails.application.config.assets.precompile += %w( jquery.dataTables.min.js )
Rails.application.config.assets.precompile += %w( dataTables.bootstrap.min.js )
Rails.application.config.assets.precompile += %w( dataTables.responsive.js )
Rails.application.config.assets.precompile += %w( jquery-ui-1.10.4.custom.js )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
