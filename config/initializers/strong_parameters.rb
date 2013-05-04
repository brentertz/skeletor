# Secure all models by default
ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)
