class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.size <= 1
    pivot = array[0]
    left = []
    right = []
    (1...array.length).each do |idx|
      if array[idx] < pivot
        left << array[idx]
      else
        right << array[idx]
      end
    end
    return sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= Proc.new{|a,b| a <=> b}
    idx = partition(array, start, length, &prc)

    sort2!(array, start, idx - start, &prc)
    sort2!(array, idx + 1, length + start - idx - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new{|a,b| a <=> b}
    pivot = array[start]
    swap_idx = start + 1
    ((start + 1)...(start + length)).each do |idx|
      if prc.call(array[idx], pivot) == -1
        array[idx], array[swap_idx] = array[swap_idx], array[idx] if swap_idx != idx
        swap_idx += 1
      end
    end
    array[start], array[swap_idx - 1] = array[swap_idx - 1], array[start]
    return swap_idx - 1
  end
end
