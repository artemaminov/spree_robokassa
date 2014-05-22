module SpreeRobokassa
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)
    config.after_initialize do |app|
      app.config.spree.payment_methods += [Spree::BillingIntegration::Robokassa]
    end

    initializer 'spree_robokassa' do
      ActionView::Base.send :include, ActiveMerchant::Billing::Integrations::ActionViewHelper
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/spree/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc


  end
end
