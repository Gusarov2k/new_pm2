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

		before { get :show, id: question }

		it 'assings the requested question to @question'do
			expect(assigns(:question)).to eq question
		end

		it 'renders show view' do
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do

		before { get :new }

		it 'assigns a new Question to @question' do
			#Проверка на то что так переменная которая находиться в нутри переменной question созданный экземпляр
			# класса Question
			expect(assigns(:question)).to be_a_new(Question)
		end		

		it 'renders new view' do
			expect(response).to render_template :new
		end
	end

	describe 'GET #edit' do
		let(:question) { create(:question) }
		before { get :show, id: question }

		it 'assings the requested question to @question'do
			expect(assigns(:question)).to eq question
		end

		it 'renders edit view' do
			expect(response).to render_template :new
		end
	end
end
