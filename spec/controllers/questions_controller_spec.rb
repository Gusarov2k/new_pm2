require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

	let(:question) { create(:question) }


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
		
		before { get :edit, id: question }

		it 'assings the requested question to @question'do
			expect(assigns(:question)).to eq question
		end

		it 'renders edit view' do
			expect(response).to render_template :edit
		end
	end

	describe 'POST #create' do
		# Два пути если успешно создается объект то один если нет то другой
		
		# Контекст это тоже что и describe просто так более наглядно разделять внутри describe
		context 'with valid attributes' do
			it 'saves the new question in the database' do
				# attributes_for(:question) возвращает хешь из созданной нами фабрики
				# Т.е. мы ожидаем что код который передается внутри {} изменит (to change) Question, :count на 1
				expect{ post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
			end
			it 'redirects to show view'	do
				post :create, question: attributes_for(:question)
				expect(response).to redirect_to question_path(assigns(:question))
			end
		end

		# Если неправильные атрибуты
		context 'with invalid attributes' do
			it 'does not save the question' do
				expect{ post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
			end

			it 're-renders new view' do
				post :create, question: attributes_for(:invalid_question)
				expect(response).to render_template :new
			end
		end

	end

	describe 'PATCH #update' do
		context 'valid attributes' do
			it 'assigns the requested question to @question' do
				patch :update, id: question, question: attributes_for(:question)
				expect(assigns(:question)).to eq question
			end

			it 'changes question attributes' do
				patch :update, id: question, question: { title: 'new title', body: 'new body' }
				# Перезагрузка что бы не взяло старые данные из хеша
				question.reload
				expect(question.title).to eq 'new title'
				expect(question.body).to eq 'new body'
			end

			it 'redirects to the updated question' do
				patch :update, id: question, question: attributes_for(:question)
				expect(response).to redirect_to question
			end
		end

		context 'invalid attributes' do

			before { patch :update, id: question, question: { title: 'new title', body: nil } }

			it 'does not change question attributes' do
				
				# Перезагрузка что бы не взяло старые данные из хеша
				question.reload
				expect(question.title).to eq 'MyString'
				expect(question.body).to eq 'MyText'
			end

			it 're-renders edit view' do
				expect(response).to render_template :edit
			end
		end
	end
end
