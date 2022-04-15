# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# ./bin/rails css:install:bootstrap added this
Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap-icons/font")
# left here as a reference, one can import e.g. flatpickr assets with this technique

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
