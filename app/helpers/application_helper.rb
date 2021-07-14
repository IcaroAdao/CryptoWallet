module ApplicationHelper
    def para_data_BR(data_us)
        data_us.strftime("%d/%m/%Y")
    end
    
    def retornar_ambiente 
        if Rails.env.development?
            "Desenvolvimento"
        elsif Rails.env.production?
            "Produção"
        else 
            "Teste"
        end
    end
end
