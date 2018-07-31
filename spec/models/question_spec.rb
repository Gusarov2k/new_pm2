require 'rails_helper'


RSpec.describe Question, type: :model do

	
	

	#Проверяем что у нас валидируется title
  # it 'validates presence of body' do
  # 	expect(Question.new(body: '123')).to_not be_valid
  # end
    # С помощью Should matchers краткая запись
	it { should validate_presence_of :body }


	#Проверяем что у нас валидируется title
  # it 'validates presence of title' do
  # 	expect(Question.new(title: '123')).to_not be_valid
  # end
  # С помощью Should matchers краткая запись
  it { should validate_presence_of :title }
end
