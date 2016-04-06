CitizenBudget::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = true

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store
  config.cache_store = :dalli_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # @todo Shouldn't be necessary to add active_admin assets.
  config.assets.precompile += %w(
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
    individual/shims/canvas-blob.js
    individual/shims/color-picker.js
    individual/shims/combos/1.js
    individual/shims/combos/10.js
    individual/shims/combos/11.js
    individual/shims/combos/12.js
    individual/shims/combos/13.js
    individual/shims/combos/14.js
    individual/shims/combos/15.js
    individual/shims/combos/16.js
    individual/shims/combos/17.js
    individual/shims/combos/18.js
    individual/shims/combos/2.js
    individual/shims/combos/21.js
    individual/shims/combos/22.js
    individual/shims/combos/23.js
    individual/shims/combos/25.js
    individual/shims/combos/27.js
    individual/shims/combos/28.js
    individual/shims/combos/29.js
    individual/shims/combos/3.js
    individual/shims/combos/30.js
    individual/shims/combos/31.js
    individual/shims/combos/33.js
    individual/shims/combos/34.js
    individual/shims/combos/4.js
    individual/shims/combos/5.js
    individual/shims/combos/6.js
    individual/shims/combos/7.js
    individual/shims/combos/8.js
    individual/shims/combos/9.js
    individual/shims/combos/97.js
    individual/shims/combos/98.js
    individual/shims/combos/99.js
    individual/shims/details.js
    individual/shims/dom-extend.js
    individual/shims/es5.js
    individual/shims/es6.js
    individual/shims/excanvas.js
    individual/shims/filereader-xhr.js
    individual/shims/FlashCanvas/canvas2png.js
    individual/shims/FlashCanvas/flashcanvas.js
    individual/shims/FlashCanvas/flashcanvas.swf
    individual/shims/FlashCanvasPro/canvas2png.js
    individual/shims/FlashCanvasPro/flash10canvas.swf
    individual/shims/FlashCanvasPro/flash9canvas.swf
    individual/shims/FlashCanvasPro/flashcanvas.js
    individual/shims/form-combat.js
    individual/shims/form-core.js
    individual/shims/form-datalist-lazy.js
    individual/shims/form-datalist.js
    individual/shims/form-fixrangechange.js
    individual/shims/form-inputmode.js
    individual/shims/form-message.js
    individual/shims/form-native-extend.js
    individual/shims/form-number-date-api.js
    individual/shims/form-number-date-ui.js
    individual/shims/form-shim-extend.js
    individual/shims/form-shim-extend2.js
    individual/shims/form-validation.js
    individual/shims/form-validators.js
    individual/shims/forms-picker.js
    individual/shims/geolocation.js
    individual/shims/i18n/formcfg-ar.js
    individual/shims/i18n/formcfg-bg.js
    individual/shims/i18n/formcfg-ca.js
    individual/shims/i18n/formcfg-ch-CN.js
    individual/shims/i18n/formcfg-cs.js
    individual/shims/i18n/formcfg-de.js
    individual/shims/i18n/formcfg-el.js
    individual/shims/i18n/formcfg-en.js
    individual/shims/i18n/formcfg-es.js
    individual/shims/i18n/formcfg-fa.js
    individual/shims/i18n/formcfg-fi.js
    individual/shims/i18n/formcfg-fr.js
    individual/shims/i18n/formcfg-he.js
    individual/shims/i18n/formcfg-hi.js
    individual/shims/i18n/formcfg-hu.js
    individual/shims/i18n/formcfg-it.js
    individual/shims/i18n/formcfg-ja.js
    individual/shims/i18n/formcfg-lt.js
    individual/shims/i18n/formcfg-nl.js
    individual/shims/i18n/formcfg-no.js
    individual/shims/i18n/formcfg-pl.js
    individual/shims/i18n/formcfg-pt-BR.js
    individual/shims/i18n/formcfg-pt-PT.js
    individual/shims/i18n/formcfg-pt.js
    individual/shims/i18n/formcfg-ru.js
    individual/shims/i18n/formcfg-sv.js
    individual/shims/i18n/formcfg-zh-CN.js
    individual/shims/i18n/formcfg-zh-TW.js
    individual/shims/jme/alternate-media.js
    individual/shims/jme/base.js
    individual/shims/jme/controls.css
    individual/shims/jme/jme.eot
    individual/shims/jme/jme.svg
    individual/shims/jme/jme.ttf
    individual/shims/jme/jme.woff
    individual/shims/jme/mediacontrols-lazy.js
    individual/shims/jme/mediacontrols.js
    individual/shims/jme/playlist.js
    individual/shims/jpicker/images/AlphaBar.png
    individual/shims/jpicker/images/bar-opacity.png
    individual/shims/jpicker/images/Bars.png
    individual/shims/jpicker/images/map-opacity.png
    individual/shims/jpicker/images/mappoint.gif
    individual/shims/jpicker/images/Maps.png
    individual/shims/jpicker/images/NoColor.png
    individual/shims/jpicker/images/picker.gif
    individual/shims/jpicker/images/preview-opacity.png
    individual/shims/jpicker/images/rangearrows.gif
    individual/shims/jpicker/jpicker.css
    individual/shims/matchMedia.js
    individual/shims/mediacapture-picker.js
    individual/shims/mediacapture.js
    individual/shims/mediaelement-core.js
    individual/shims/mediaelement-debug.js
    individual/shims/mediaelement-jaris.js
    individual/shims/mediaelement-native-fix.js
    individual/shims/mediaelement-yt.js
    individual/shims/moxie/flash/Moxie.cdn.swf
    individual/shims/moxie/flash/Moxie.min.swf
    individual/shims/moxie/js/moxie-html4.js
    individual/shims/moxie/js/moxie-swf.js
    individual/shims/picture.js
    individual/shims/plugins/jquery.ui.position.js
    individual/shims/range-ui.js
    individual/shims/sizzle.js
    individual/shims/sticky.js
    individual/shims/styles/color-picker.png
    individual/shims/styles/forms-ext.css
    individual/shims/styles/forms-picker.css
    individual/shims/styles/progress.gif
    individual/shims/styles/progress.png
    individual/shims/styles/shim-ext.css
    individual/shims/styles/shim.css
    individual/shims/styles/transparent.png
    individual/shims/styles/widget.eot
    individual/shims/styles/widget.svg
    individual/shims/styles/widget.ttf
    individual/shims/styles/widget.woff
    individual/shims/swf/JarisFLVPlayer.swf
    individual/shims/swfmini-embed.js
    individual/shims/swfmini.js
    individual/shims/track-ui.js
    individual/shims/track.js
    individual/shims/url.js
    individual/shims/usermedia-core.js
    individual/shims/usermedia-shim.js
    simulators/default_simulator.js
    simulators/deviation_simulator.js
    simulators/impact_simulator.js
    simulators/tax_simulator.js
    mobile.css
    print.css
  )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  config.action_mailer.default_url_options = {host: ENV['ACTION_MAILER_HOST']}

  # https://devcenter.heroku.com/articles/rack-cache-memcached-static-assets-rails31
  config.static_cache_control = 'public, max-age=2592000' # 30 days
  config.action_dispatch.rack_cache = {
    metastore: Dalli::Client.new,
    entitystore: 'file:tmp/cache/rack/body',
    allow_reload: false,
  }
end
