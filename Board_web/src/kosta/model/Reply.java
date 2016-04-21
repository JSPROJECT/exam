package kosta.model;

import java.io.Serializable;

public class Reply implements Serializable {
		private int r_id;
		private String r_name;
		private String r_content;
		private int b_id;
		
		public Reply(){}

		public Reply(int r_id, String r_name, String r_content, int b_id) {
			super();
			this.r_id = r_id;
			this.r_name = r_name;
			this.r_content = r_content;
			this.b_id = b_id;
		}

		public int getR_id() {
			return r_id;
		}

		public void setR_id(int r_id) {
			this.r_id = r_id;
		}

		public String getR_name() {
			return r_name;
		}

		public void setR_name(String r_name) {
			this.r_name = r_name;
		}

		public String getR_content() {
			return r_content;
		}

		public void setR_content(String r_content) {
			this.r_content = r_content;
		}

		public int getB_id() {
			return b_id;
		}

		public void setB_id(int b_id) {
			this.b_id = b_id;
		}

		@Override
		public String toString() {
			return "reply [r_id=" + r_id + ", r_name=" + r_name + ", r_content="
					+ r_content + ", b_id=" + b_id + "]";
		}
		
		

}
