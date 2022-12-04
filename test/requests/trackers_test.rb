require 'json'

describe '/trackers' do
  let(:app) { Rack::MockRequest.new(App.instance) }

  after { $redis.flushdb }

  describe 'GET' do
    subject { app.get('/trackers') }

    it do
      json_body = JSON.parse(subject.body)
      expect(json_body['trackers']).must_equal([])
      expect(subject.status).must_equal(200)
    end
  end

  describe 'POST' do
    subject { app.post('/trackers', params: params) }

    describe 'Success' do
      let(:params) do
        {
          ip: '127.0.0.0'
        }
      end

      it do
        expect(subject.status).must_equal(204)
      end
    end

    describe 'Error' do
      let(:params) { {} }

      it do
        json_body = JSON.parse(subject.body)
        expect(json_body['errors']['ip']).must_equal(['is missing'])
        expect(subject.status).must_equal(422)
      end
    end
  end

  describe 'DELETE' do
    subject { app.delete('/trackers', params: params) }

    describe 'Success' do
      let(:params) do
        {
          ip: '127.0.0.0'
        }
      end

      it do
        expect(subject.status).must_equal(204)
      end
    end

    describe 'Error' do
      let(:params) { {} }

      it do
        json_body = JSON.parse(subject.body)
        expect(json_body['errors']['ip']).must_equal(['is missing'])
        expect(subject.status).must_equal(422)
      end
    end
  end
end