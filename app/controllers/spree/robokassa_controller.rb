module Spree
  class RobokassaController < Spree::CheckoutController
    require 'active_merchant'
    require 'active_merchant/billing/integrations/action_view_helper'
    ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

    skip_before_filter :verify_authenticity_token, :only => [:result, :success, :fail]
    #before_filter :load_order, :only => [:result, :success, :fail]
    ssl_required :show

    def show
      #@order = Spree::Order.find_by_number(params[:order_number])
      robokassa_payment_method = Spree::PaymentMethod.find_by_type('Spree::BillingIntegration::Robokassa')
      @payment_method = @order.available_payment_methods.detect{|x| x.id == robokassa_payment_method.id }

      if @order.blank? || @payment_method.blank?
        flash[:error] = I18n.t("invalid_arguments")
        redirect_to :back
      else
        #@signature = ActiveMerchant::Billing::Integrations::Robokassa.notification(params)
        #    Digest::MD5.hexdigest([
        #  @payment_method.options[:mrch_login],
        #  @order.total, @order.id, @payment_method.options[:password1]
        #].join(':')).upcase
        render :action => :show
      end
    end

    def result
      payment = @order.payments.create(
          amount: params["OutSum"].to_f,
          payment_method_id: @order.available_payment_methods.first.id)

      if @order && @payment_method && valid_signature?(@payment_method.options[:password2])
        # Need to force checkout to complete state
        until @order.state == "complete"
          if @order.next!
            @order.update!
            state_callback(:after)
          end
        end
        render :text => "OK#{@order.id}"
      else
        payment.failure!
        render :text => "Invalid Signature"
      end

    end

    def success
      if @order && @payment_method && valid_signature?(@payment_method.options[:password1]) && @order.complete?
        session[:order_id] = nil
        redirect_to order_path(@order), :notice => I18n.t("payment_success")
      else
        flash[:error] =  t("payment_fail")
      end
    end

    def fail
      flash[:error] = t("payment_fail")
      redirect_to @order.blank? ? root_url : checkout_state_path("payment")
    end

    private

    def valid_signature?(key)
      params["SignatureValue"].upcase == Digest::MD5.hexdigest([params["OutSum"], params["InvId"], key ].join(':')).upcase
    end


  end
end