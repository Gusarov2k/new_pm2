require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	describe 'GET #index' do
		# Метод let назначение переменных в тестах
		# Данный метод выполняется только когда вызывается и далее сохраняет эти значения для последующего вызова
		let(:questions) { create_list(:question, 2) }

		before do
			# Делаем запрос
			get :index
		end

		# Заполняте массив все вопросов
		it 'populates an array of all questions' do
			# Провереяем что в instans varibale :questions есть значения ниших созданные ранее переменных
			expect(assigns(:questions)).to match_array(questions)
		end

		# отрендерить index
		it 'renders index view' do
			# Ожидаем что наш ответ от контроллера такой же как шаблон :index (render_template :index)
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do

		let(:question) { create(:question) }

		it 'assings the requested question to @question'do
			get :show, id: question
			expect(assigns(:question)).to eq question
		end

		it 'renders show view' do
			get :show, id: question
			expect(response).to render_template :show
		end
	end

end
