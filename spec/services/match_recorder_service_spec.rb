require 'rails_helper'

RSpec.describe MatchRecorderService do
  describe '.call' do
    context 'when file is empty' do
      let(:file_path) { Rails.root.join('spec', 'support', 'empty_log') }
      let(:file)      { File.open(file_path) }
      let(:service)   { MatchRecorderService.new(file) }

      it 'expects to not create matches' do
        expect { service.call }.not_to change(Match, :count)
      end

      it 'expects to not create plays' do
        expect { service.call }.not_to change(Play, :count)
      end

      it 'expects to not create players' do
        expect { service.call }.not_to change(Player, :count)
      end

      it 'expects to not create weapons' do
        expect { service.call }.not_to change(Weapon, :count)
      end
    end

    context 'when file has an line without the data' do
      let(:file_path) { Rails.root.join('spec', 'support', 'corrupted_data_log') }
      let(:file)      { File.open(file_path) }
      let(:service)   { MatchRecorderService.new(file) }

      it 'expects to not create matches' do
        expect { service.call }.not_to change(Match, :count)
      end

      it 'expects to not create plays' do
        expect { service.call }.not_to change(Play, :count)
      end

      it 'expects to not create players' do
        expect { service.call }.not_to change(Player, :count)
      end

      it 'expects to not create weapons' do
        expect { service.call }.not_to change(Weapon, :count)
      end
    end

    context 'when file has an line without the timestamp' do
      let(:file_path) { Rails.root.join('spec', 'support', 'corrupted_time_log') }
      let(:file)      { File.open(file_path) }
      let(:service)   { MatchRecorderService.new(file) }


      it 'expects to not create matches' do
        expect { service.call }.not_to change(Match, :count)
      end

      it 'expects to not create plays' do
        expect { service.call }.not_to change(Play, :count)
      end

      it 'expects to not create players' do
        expect { service.call }.not_to change(Player, :count)
      end

      it 'expects to not create weapons' do
        expect { service.call }.not_to change(Weapon, :count)
      end
    end

    context 'when match file has the required data to create a new match' do
      let(:file_path)   { Rails.root.join('spec', 'support', 'new_match_log') }
      let(:file)        { File.open(file_path) }
      let(:service)     { MatchRecorderService.new(file) }

      it 'expects to not create matches' do
        expect { service.call }.to change(Match, :count).by(1)
      end

      it 'expects to not create plays' do
        expect { service.call }.not_to change(Play, :count)
      end

      it 'expects to not create players' do
        expect { service.call }.not_to change(Player, :count)
      end

      it 'expects to not create weapons' do
        expect { service.call }.not_to change(Weapon, :count)
      end
    end

    context 'when match file has the required data to create a complete match' do
      let(:file_path)   { Rails.root.join('spec', 'support', 'complete_match_log') }
      let(:file)        { File.open(file_path) }
      let(:service)     { MatchRecorderService.new(file) }

      it 'expects to create a new match in database' do
        expect { service.call }.to change(Match, :count).by(1)
      end

      it 'expects to create new players in database' do
        expect { service.call }.to change(Player, :count).by(2)
      end

      it 'expects to create new weapons in database' do
        expect { service.call }.to change(Weapon, :count).by(1)
      end

      it 'expects to create a new play in database' do
        expect { service.call }.to change(Play, :count).by(2)
      end
    end
  end
end
