def self.match_ids( id_set, i, matched_ids, product )
  if i < id_set.length - 1
    id_set[ i ].each do | j |
      match_ids( id_set, i + 1, matched_ids + [ j ], product )
    end
  else
    id_set[ i ].each do | j |
      matched_set = matched_ids + [ j ]
      product_variants_with_option_values( matched_set, product.id ).first_or_initialize( :product_id => product.id ).tap do | o |
        o.assign_attributes(
          :option_values => Spree::OptionValue.find( matched_set ),
          :sku => ( [ product.id ] + matched_set ).join( '-' ),
          :track_inventory => false
        )
        o.save

        size_option_value = o.option_values.where( :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id ).first

        o.assign_attributes(
          :weight => size_option_value ? rock_size_value_weights[ size_option_value.name ] : 30.00
        )
        o.save

        Spree::Price.find_or_initialize_by( :variant_id => o.id ).tap do | p |
          p.assign_attributes(
            :amount => !size_option_value ? product.master.price : [
              product.master.price,
              rock_size_value_prices[ size_option_value.name ]
            ].sum,
            :currency => 'USD'
          )
          p.save
        end
      end
    end
  end
end

def self.product_variants_with_option_values( option_value_ids, product_id )
  Spree::Variant.joins( :option_value_variants ).where( :product_id => product_id ).where( ( [ 'spree_variants.id IN ( SELECT variant_id FROM spree_option_value_variants WHERE option_value_id = ? )' ] * option_value_ids.count ).join( ' AND ' ), *option_value_ids )
end

def self.rock_size_value_prices
  {
    'small' => 0.00,
    'medium' => 25.00,
    'large' => 50.00,
    'extra-large' => 75.00
  }
end

def self.rock_size_value_weights
  {
    'small' => 15.00,
    'medium' => 25.00,
    'large' => 40.00,
    'extra-large' => 60.00
  }
end

def self.write_or_overwrite( record )
  if record.new_record? && $require_write_permission
    puts "There is a new #{record.class.name} record: "
    ap record
    puts 'Would you like to save this record to the database? (y/n)'
    if yes?( STDIN.gets.chomp )
      puts 'Saving...'
      o.save
      puts 'Record has been saved.'
      return true
    else
      puts 'The record was not saved.'
      return false
    end
  elsif !record.new_record? && $require_overwrite_permission
    if record.changed?
      puts "There is a matching #{record.class.name} record already in the database. The following attributes will be changed if it is overwritten: "
      ap record.changes
      puts 'Would you like to overwrite the record in the database? (y/n)'
      if yes?( STDIN.gets.chomp )
        puts 'Saving...'
        record.save
        puts 'The record has been saved.'
        return true
      else
        puts 'The record was not saved.'
        return false
      end
    else
      return true
    end
  else
    record.save
  end
end
