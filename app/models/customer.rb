class Customer < ActiveRecord::Base
  
  has_many :messages
  has_many :specials, dependent: :destroy
  has_many :properties, dependent: :destroy
  
  default_scope {order(:id)}

  attr_accessor :password_confirm, :password_change

  validates :type_client, :creci, presence: true
  validates :cep, :uf, :city, :address, :fantasy_name, :responsible_name, presence: true
  validates :telephone, :responsible_telephone, presence: true
  validates :uf, length: {maximum: 2, minimum: 2}
  validates :contact_email, :cadastre_email, :contact_email_optional,email: true, presence: true

  validates :cpf, cpf: true, presence: true, if: :is_cpf?
  validates :cnpj, cnpj: true, presence: true, if: :is_cnpj?
  validates :social_reason, presence: true, if: :is_cnpj?

  validates :username, uniqueness: true, presence: true
  validates :password, :password_confirm, presence: true, length: { minimum: 6, maximum: 28}, on: :create

  validate  :password_valid?, if: :password_update?

  validates :logo_path, file_size: { less_than_or_equal_to: 10.megabytes.to_i,
                                 message: "Arquivo não pode exceder 10 MB" }

  validates :logo_path, file_content_type: { allow: ['image/jpeg', 'image/png'],
                                         message: 'Somente arquivos .jpg ou .png' }


  mount_uploader :logo_path, ::ImageUploader 

  def label_name
    "#{self.id} - #{self.fantasy_name.downcase}"
  end

  def email
    self.cadastre_email
  end
  
  
  private

  def password_update?
    self.password_change.present?
  end

  def password_valid?
    errors.add(:password, 'Senhas não são iguais') if self.password != self.password_confirm
  end

  def is_cpf?
    self.pessoa_física?
  end

  def is_cnpj?
    self.pessoa_jurídica?
  end

  enum type_client: ['pessoa_física', 'pessoa_jurídica']
end

