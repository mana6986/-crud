package com.example.test1.model;

public class User {
	 private String email;
	    private String password;
	    private String name;
	    private String address;
	    private String addressDetail; // address_detail 컬럼명과 일치하도록 수정
	    private String postalCode; // postal_code 컬럼명과 일치하도록 수정
	    private String note;
	    private String phone;

	    @Override
	    public String toString() {
	        StringBuilder sb = new StringBuilder();
	        sb.append("email: ").append(email).append(", ");
	        sb.append("password: ").append(password).append(", ");
	        sb.append("name: ").append(name).append(", ");
	        sb.append("address: ").append(address).append(", ");
	        sb.append("address_detail: ").append(addressDetail).append(", ");
	        sb.append("postal_code: ").append(postalCode).append(", ");
	        sb.append("note: ").append(note).append(", ");
	        sb.append("phone: ").append(phone);
	        return sb.toString();
	    }

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getAddress() {
			return address;
		}

		public void setAddress(String address) {
			this.address = address;
		}

		public String getAddressDetail() {
			return addressDetail;
		}

		public void setAddressDetail(String addressDetail) {
			this.addressDetail = addressDetail;
		}

		public String getPostalCode() {
			return postalCode;
		}

		public void setPostalCode(String postalCode) {
			this.postalCode = postalCode;
		}

		public String getNote() {
			return note;
		}

		public void setNote(String note) {
			this.note = note;
		}

		public String getPhone() {
			return phone;
		}

		public void setPhone(String phone) {
			this.phone = phone;
		}


	
}    
    // 각 필드의 getter와 setter 메서드는 생략합니다.

