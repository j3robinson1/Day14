require 'rails_helper'
describe HospitalsController do
  let(:hospital) do
    Hospital.create({name: 'blah', location: 'locationblah'})
  end
  describe 'GET #show' do
  it 'should show a hospital' do
    get :show, id: hospital
    expect(assigns(:hospital)).to eq hospital
    expect(assigns(:hospital).class).to eq Hospital
    expect(assigns(:patients)).to eq []
  end
  it 'should initialize doctor' do
    get :show, id: hospital
    expect(assigns(:doctor)).to eq Doctor.new
  end
end
  describe 'POST #create_doctor' do
    it 'should create a doctor' do
      get :create_doctor, id: hospital, doctor: { name: "blah"}
      expect(assigns(:hospital)).to eq hospital
      expect(assigns(:doctor).class).to eq Doctor
      expect(assigns(:doctor).doctorable_id).to eq hospital.id
      expect(assigns(:doctor).doctorable_type).to eq "Hospital"
      expect(response).to redirect_to hospital_path(hospital)
    end
  end
  describe 'GET #new' do
    it 'should initialize a hospital' do
      get :new
      expect(assigns(:hospital).class).to eq Hospital
    end
  end
  describe 'POST #destroy' do
    it 'should delete hospital' do
      expect(assigns(:hospital)).to eq nil
    end
    it 'should redirect to hospitals_path' do
      expect(response).to redirect_to hospitals_path
    end
  end
  describe 'GET #index' do
    let!(:hospital1) {
      Hospital.create({name: "blah1", location: "blank"})
    }

    let!(:hospital2) {
      Hospital.create({name: "blah2", location: "blank"})
    }

    let!(:hospital3) {
      Hospital.create({name: "blah3", location: "blank"})
    }

    it 'should not return any hospitals' do
      get :index, search: 'asdf'
      expect(assigns(:hospitals)).not_to eq(nil)
      expect(assigns(:hospitals)).to eq([])
    end

    it 'should return only 1 hospital' do
      get :index, search: 'blah1'
      expect(assigns(:hospitals)).not_to eq(nil)
      expect(assigns(:hospitals)).to eq([hospital1])
    end 

    it 'should return all 3 hospitals' do
      get :index, search: 'blah'
      expect(assigns(:hospitals)).not_to eq(nil)
      expect(assigns(:hospitals).length).to eq(3)
      expect(assigns(:hospitals)).to include(hospital1)
      expect(assigns(:hospitals)).to include(hospital2)
      expect(assigns(:hospitals)).to include(hospital3)
    end
   
    it 'should return all hospitals' do
      get :index
      expect(assigns(:hospitals)).not_to eq(nil)
      expect(assigns(:hospitals).length).to eq(3)
      expect(assigns(:hospitals)).to include(hospital1)
      expect(assigns(:hospitals)).to include(hospital2)
      expect(assigns(:hospitals)).to include(hospital3)
    end    

    it 'should return all hospitals' do
      get :index, search: ""
      expect(assigns(:hospitals)).not_to eq(nil)
      expect(assigns(:hospitals).length).to eq(3)
      expect(assigns(:hospitals)).to include(hospital1)
      expect(assigns(:hospitals)).to include(hospital2)
      expect(assigns(:hospitals)).to include(hospital3)
    end
  end
end