module Admin
  module CustomRedirectOnSave
    def self.included(base)
      base.class_eval do

        def save_redirect_url
          collection_url
        end

        def create
          super do |format|
            redirect_to save_redirect_url and return if resource.valid?
          end
        end
      
        def update
          super do |format|
            redirect_to save_redirect_url and return if resource.valid?
          end
        end
        
      end
    end
  end
end
