module Api
  module V1
    # app/controllers/api/v1/transactions_controller.rb
    class TransactionsController < ApplicationController
      before_action :set_user, only: [:create, :user_transactions]
      before_action :set_transaction, only: [:show]

      def user_transactions
        transactions = @user.transactions
        return render_empty_list if transactions.empty?

        render json: transactions, status: :ok
      end

      def index
        transactions = Transaction.all
        return render_empty_list if transactions.empty?

        render json: transactions
      end

      def show
        render json: @transaction, status: :ok
      end

      def create
        result = transaction_service

        return render json: { error: result[:error] }, status: :unprocessable_entity if result[:error]

        render json: { success: result[:success], transaction: result[:transaction] }, status: :created
      end

      private

      def render_empty_list
        render json: { empty: "No se han realizado transacciones" }
      end

      def set_transaction
        @transaction = Transaction.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Transaccion no encontrada' }, status: :not_found
      end

      def set_user
        @user = User.find(params[:user_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Usuario no encontrado' }, status: :not_found
      end

      def transaction_service
        service = TransactionService.new(@user, params[:currency_sent], params[:currency_received],
                                         params[:amount_sent].to_f)
        service.process_transaction
      end
    end
  end
end
