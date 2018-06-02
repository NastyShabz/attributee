# frozen_string_literal: true

class TestUser
  include Attributee

  def_attribute :name
  def_attribute :email
  def_attribute :password
  def_attribute :password_confirmation
end 

RSpec.describe Attributee do
  attributes = {
    name: 'James',
    email: 'james@example.com',
    password: '12345678',
    password_confirmation: '12345678'
  }

  describe 'instance' do
    subject do
      TestUser.new attributes
    end

    describe 'accessors' do
      it 'has accessors for all the defined attributes' do
        expect { subject.name = 'Pete' }
          .to change { subject.name }.from('James').to('Pete')

        expect { subject.email = 'pete@example.com' }
          .to change { subject.email }.from('james@example.com').to('pete@example.com')

        expect { subject.password = '87654321'}
          .to change { subject.password }.from('12345678').to('87654321')

        expect { subject.password_confirmation = '87654321'}
          .to change { subject.password_confirmation }.from('12345678').to('87654321')
      end

      describe '#attributes' do
        it 'returns a hash of all the attributes' do
          expect(subject.attributes).to eq attributes
        end
      end

      describe '#attribute' do
        it 'returns an attribute object by the attribute name' do
          expect(subject.attribute(:name)).to be_instance_of Attributee::Attribute
        end
      end
    end
  end
end
