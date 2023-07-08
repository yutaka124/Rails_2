class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, presence: true
  validates :check_out, presence: true
  validate :check_out_after_check_in
  validate :check_in_not_in_the_past
  validates :guests, numericality: { greater_than_or_equal_to: 1 }

  private

  def check_out_after_check_in
    if check_out.present? && check_in.present? && check_out <= check_in
      errors.add(:check_out, "はチェックインの日付より後でなければなりません")
    end
  end  

  def check_in_not_in_the_past
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, "は過去の日付を選択できません")
    end
  end
end
