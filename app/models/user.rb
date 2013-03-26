class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_reader :is_admin

  validates_uniqueness_of :email
 
  has_many :books

  has_many :likes
  has_many :liked_books, through: :likes, source: :book

  def has_liked?(book)
    liked_books.include?(book)
  end

  def like_for(book)
    likes.where(book_id: book.id).first
  end

=begin
  def self.is_current_user_admin?
    current_user && current_user.is_admin?
  end
=end  
end