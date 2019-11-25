class Transaction < ApplicationRecord

  before_create :generate_blockchain

  def generate_blockchain
    previous_transaction = Transaction.last
    self.block_hash = calculate_hash(previous_transaction)
    self.block_index = previous_transaction&.block_index ? previous_transaction&.block_index + 1 : 0
  end

  def calculate_hash(previous_transaction)
    sha = Digest::SHA256.new
    puts "#{name} #{value} #{due_date} #{created_at} #{updated_at} #{previous_transaction&.block_hash&.to_s || '0' }"
    sha.update(name.to_s + value.to_s + due_date.to_s + created_at.to_s + updated_at.to_s + (previous_transaction&.block_hash&.to_s || '0') + (previous_transaction&.block_index&.to_s || '0') )
    sha.hexdigest
  end

  def hash_valid?
    previous_transaction = Transaction.find_by(block_index: self.block_index - 1)
    self.calculate_hash(previous_transaction) == self.block_hash
  end
end
