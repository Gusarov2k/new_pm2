require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	describe 'GET #index' do

		before do
			@questions = FactoryBot.create_list(:question, 2)
			# Делаем запрос
			get :index
		end
		# Заполняте массив все вопросов
		it 'populates an array of all questions' do
			
	

			
			# Провереяем что в instans varibale :questions есть значения ниших созданные ранее переменных
			expect(assigns(:questions)).to match_array(@questions)
		end

		# отрендерить index
		it 'renders index view' do
			
			# Ожидаем что наш ответ от контроллера такой же как шаблон :index (render_template :index)
			expect(response).to render_template :index
		end
	end

end
