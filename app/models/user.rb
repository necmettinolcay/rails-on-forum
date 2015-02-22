class User < ActiveRecord::Base
  has_secure_password

  validates :username,  prensece:   true,
	  	        uniqueness: { case_sensitive: false },
		        length:     { in: 4..12 },
		        format:	    { with:\/A[a-zA-Z][a-zA-Z0-9_-]*\Z/ }
  validates :firstname, presence:   true
  validates :lastname,  presence:   true
  validates :email,     presence:   true,
	                uniqueness: { case_sensitive: false },
			email:      true
  validates :password,  presence:   true,
	  		length:     { minimum: 6 }
end
