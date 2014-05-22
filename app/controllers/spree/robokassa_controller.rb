module Spree
  class RobokassaController < Spree::StoreController

    before_filter :find_order
    before_filter :find_or_create_payment
    before_filter :find_payment_method
    before_filter :create_notification

    skip_before_filter :verify_authenticity_token
    ssl_required :show

    helper 'spree/orders'

    def result
      if @order.completed?
        render :text => "Order already completed!" and return
      end
      @payment.amount = @notification.amount
      @payment.payment_method_id = @payment_method.id
      @payment.state = "checkout" if @payment.persisted?
      @payment.save
      if @notification.amount >= @order.total && @payment_method && @notification.acknowledge
        @order.next
        @payment.complete
        @order.update!
        render :text => @notification.success_response
      else
        render :text => "Invalid Signature"
      end
    end

    def success
      if @order && @payment_method && @notification.acknowledge && @order.complete?
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

    def find_order
      @order = Order.find params[:InvId]
    end

    def find_or_create_payment
      @payment = @order.payments.last || @order.payments.build
    end

    def find_payment_method
      @payment_method = Spree::BillingIntegration::Robokassa.current
    end

    def create_notification
      @notification = @payment_method.provider_class::Notification.new(request.raw_post, :secret => @payment_method.preferred_password2)
    end


  end
end
