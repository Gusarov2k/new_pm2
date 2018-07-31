require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	describe 'GET #index' do
		# Заполняте массив все вопросов
		it 'populates an array of all questions' do
			questions1 = FactoryBot.create(:question)
			questions2 = FactoryBot.create(:question)

			get :index
			# Провереяем что в instans varibale :questions есть значения ниших созданные ранее переменных
			expect(assigns(:questions)).to match_array([questions1, questions2])
		end

		# отрендерить index
		it 'renders index view' do
			# Делаем запрос
			get :index
			# Ожидаем что наш ответ от контроллера такой же как шаблон :index (render_template :index)
			expect(response).to render_template :index
		end
	end

end
