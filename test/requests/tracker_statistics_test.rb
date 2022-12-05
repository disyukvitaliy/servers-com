# frozen_string_literal: true

require 'json'

describe '/tracker_statistics' do
  let(:app) { Rack::MockRequest.new(App.instance) }

  after { Ping.truncate }

  describe 'GET' do
    subject { app.get('/tracker_statistics', params:) }

    describe 'Success' do
      let(:params) do
        {
          ip: '127.0.0.0', start: Time.now - (60 * 60 * 24 * 30), end: Time.now
        }
      end

      it do
        json_body = JSON.parse(subject.body)
        expect(json_body['statistics']['attempts_total']).must_equal(0)
        expect(subject.status).must_equal(200)
      end
    end

    describe 'Error' do
      let(:params) { {} }

      it do
        json_body = JSON.parse(subject.body)
        expect(json_body['errors']['start']).must_equal(['is missing'])
        expect(subject.status).must_equal(422)
      end
    end
  end
end
