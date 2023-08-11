package linkedlist

import (
	"errors"
)

type List struct {
	head *Node
	size int
}

type Node struct {
	Value int
	next  *Node
}

func New(elements []int) *List {
	list := List{}

	for _, i := range elements {
		list.Push(i)
	}

	return &list
}

func (l *List) Size() int {
	return l.size
}

func (l *List) Push(element int) {
	if l.head == nil {
		l.head = &Node{Value: element}
	} else {
		tail := l.head
		for tail.next != nil {
			tail = tail.next
		}
		tail.next = &Node{Value: element}
	}

	l.size += 1
}

func (l *List) Pop() (int, error) {
	if l.head == nil {
		return 0, errors.New("can't pop from empty list")
	}

	if l.head.next == nil {
		v := l.head.Value
		l.head = nil
		l.size = 0
		return v, nil
	}

	// otherwise 2+ elements, go until we find the penultimate
	penultimate := l.head
	for penultimate.next.next != nil {
		penultimate = penultimate.next
	}
	v := penultimate.next.Value
	penultimate.next = nil
	l.size -= 1
	return v, nil
}

func (l *List) Array() []int {
	result := []int{}

	tail := l.head
	for tail != nil {
		result = append(result, tail.Value)
		tail = tail.next
	}

	return result
}

func (l *List) Reverse() *List {
	var prev, next *Node
	cur := l.head

	for cur != nil {
		next = cur.next
		cur.next = prev
		prev = cur
		cur = next
	}
	l.head = prev

	return l
}
