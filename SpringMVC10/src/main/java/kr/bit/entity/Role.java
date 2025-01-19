package kr.bit.entity;

public enum Role {
	ADMIN(true, true), // ADMIN 상수를 선언하면서, true, true 값을 생성자에 전달
	MANAGER(true, true), // MANAGER 상수도 동일
	MEMBER_READ_ONLY(true, false), // MEMBER_READ_ONLY 상수
	MEMBER_READ_WRITE(true, true), // MEMBER_READ_WRITE 상수
	MEMBER_TEMP_USER(false, false); // 정식회원가입 직전 임시 권한 
	
	private boolean readable; // 읽기 권한
	private boolean writable; // 쓰기 권한
	
	 // 생성자
	private Role(boolean readable, boolean writable){
		this.readable = readable;
		this.writable = writable;
	}
	
	public boolean isReadable() {
		return readable;
	}
	
	public boolean isWritable() {
		return writable;
	}
	
}

/*
 * https://www.notion.so/enum-149e2244683d80f986bbe9843d4ca4c0?pvs=4
 * 열거형(enum): 기본적으로 고정된 상수들을 정의하는 용도로 사용되는 특별한 클래스(계절, 요일 등의 개념)
 * 
 * enum을 사용할 때 인스턴스를 생성할 수 있는 방식과 생성자의 동작 방식이 다르기 때문에, 
 * ADMIN(true, true)와 같은 형식이 가능하고, 생성자에 Role만 붙는 것도 허용
 * 
 * 메모리에 로드될 때, 정의된 모든 열거 상수를 생성하고 static 변수로 보관, 모든 열거 상수는 싱글턴(하나의 인스턴스만 존재)
 * (= 프로그램 로딩 시점에 한 번 생성되어 모든 곳에서 동일한 객체를 참조)
 * 
 * Role만 붙는 이유: (= private 생략가능)
 * Role 클래스의 생성자는 private입니다.
 * enum 클래스에서 private 생성자를 사용하는 이유는 외부에서 enum 상수를 임의로 생성할 수 없도록 막기 위함입니다. 
 * enum 상수는 선언될 때 이미 생성자가 호출되어 초기화되기 때문에, 외부에서 new를 통해 다른 Role 인스턴스를 생성하는 것이 불가능합니다.
 * 
 * 따라서 enum은 내부적으로 Role 상수를 생성할 때 생성자에 값을 넘겨주는 방식으로 작동하고, 이 생성자는 외부에서 직접 호출할 수 없습니다.
 * 
 * 
 * 
 * 열거 상수는 관례적으로 모두 대문자 작성이고, 언더바_ 로 연결한다.
 * 
 * */
 