class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :check_in, presence: true
  validates :check_out, presence: true
  validate :check_out_after_check_in

  private

  def check_out_after_check_in
    if check_out.present? && check_in.present? && check_out < check_in
      errors.add(:check_out, "はチェックイン日よりも後の日付を選択してください")
    end
  end
end
