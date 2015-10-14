class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
  
    if @contact.save
      name = params[:contact][:name]      #for email delivery
      email = params[:contact][:email]    #for email delivery
      body = params[:contact][:comments]  #for email delivery

      ContactMailer.contact_email(name, email, body).deliver #method from contact_email, parameters from the above variables

      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      flash[:danger] = "Error occured, message has not been sent."
      redirect_to new_contact_path
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end

end