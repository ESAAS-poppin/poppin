class Event < ApplicationRecord
    attr_accessor :venue_name

    def self.add_venue_name(evt)
        ven_id = evt.venue_id
        if ven_id != nil && ven_id != ''
          evt_ven = Venue.where(id: ven_id)
          if evt_ven != nil
            evt.venue_name = evt_ven.first.name
          end
        end
    end
end