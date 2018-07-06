class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length == 1
    pivot = array[0]
    left = sort(array.select { |el| el < pivot })
    right = sort(array.select { |el| el >= pivot })

    left + [pivot] + right
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
      return array if length <= 1
      pivot_index = partition(array, start, length, &prc)
      left = pivot_index - start
      right = length - left - 1
      sort2!(array, start, left, &prc)
      sort2!(array, pivot_index + 1, right, &prc)
      array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot_index = start
    pivot_value = array[start]

    ((pivot_index + 1)..(start + length - 1)).each do |idx|
      if prc.call(pivot_value, array[idx]) > 0
        array[idx], array[pivot_index + 1] = array[pivot_index + 1], array[idx]
        pivot_index += 1
      end
    end
    array[start], array[pivot_index] = array[pivot_index], array[start]
    pivot_index
  end 
end
