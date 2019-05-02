import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
import java.util.*;
import jess.*;
import jess.awt.TextAreaWriter;

public class InvCon extends JFrame {
	
	TextArea t;
	JButton b1, b2 ;
	JTextField  tf1, tf2, tf3;
	JLabel jl1, jl2, jl3 ,jl4;
	JRadioButton jrb1, jrb2;
	String fs;
	Rete engine ;
	
	InvCon() {
		setTitle("재정 상담");
		setLayout(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);	
		t = new TextArea(10, 40);
		JScrollPane js = new JScrollPane(t);
		js.setSize(510, 200);
		js.setLocation(20, 15);
		add(js);
		MyActionListener ml  = new MyActionListener();
		
		b1 = new JButton("상담시작");
		b1.addActionListener(ml);
		b1.setSize(125, 30);
		b1.setLocation(550, 30);
		add(b1);
		
		b2 = new JButton("초기화");
		b2.addActionListener(ml);
		b2.setSize(125, 30);
		b2.setLocation(675, 30);
		add(b2);
		
		jl1 = new JLabel("연소득");
		tf1 = new JTextField(20);
		jl1.setSize(70, 30);
		tf1.setSize(200, 30);	
		jl1.setLocation(550, 70);
	    tf1.setLocation(600, 70);
	    add(jl1);
		add(tf1);
		
		jl2= new JLabel("부양가족");
		tf2 = new JTextField(20);
		jl2.setSize(70, 30);
		tf2.setSize(200, 30);	
		jl2.setLocation(550, 110);
		tf2.setLocation(600, 110);
		add(jl2);
		add(tf2);
		
		jl3= new JLabel("저축액");
		tf3 = new JTextField(20);
		jl3.setSize(70, 30);
		tf3.setSize(200, 30);	
		jl3.setLocation(550, 150);
		tf3.setLocation(600, 150);
		add(jl3);
		add(tf3);
		
		ButtonGroup g = new ButtonGroup();
		jl4= new JLabel("소득");
		jl4.setSize(70,30);
		jl4.setLocation(550, 190);
		jrb1 = new JRadioButton("setady", true);
		jrb2 = new JRadioButton("unsteady", false);
		g.add(jrb1);
		g.add(jrb2);
		
		jrb1.setLocation(600, 190);
		jrb1.setSize(100, 30);
		jrb2.setLocation(700, 190);
		jrb2.setSize(100, 30);
		add(jl4);
		add(jrb1);
		add(jrb2);
		
		

		setSize(850,270);
		setVisible(true);
	}
	
	private class MyActionListener implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			JButton b = (JButton)e.getSource();
		if(b == b1) {
			t.append("\n \n *** 상담 의뢰인의 현황 *** \n \n" );
			t.append("연수입 : " +  "$"+ tf1.getText() + "\n");
			t.append("부양가족 : " + tf2.getText() + "명" + "\n");
			t.append("저축액 : " + "$" + tf3.getText() + "\n");
			if(jrb1.isSelected()) {
				t.append("저축 : " + jrb1.getText() + "\n");
			}
			else if(jrb2.isSelected()) {
				t.append("저축 : " + jrb2.getText() + "\n");

			}
			fs = "";
			if(jrb1.isSelected()) {
				fs = fs + "\n(assert (earnings " +  tf1.getText() + " steady))";
			}
			else if(jrb2.isSelected()) {
				fs = fs + "\n(assert (earnings " +  tf1.getText() + " unsteady))";
			}
			fs = fs + "\n(assert (dependents " +  tf2.getText() + "))";
			fs = fs + "\n(assert (amount_saved " +  tf3.getText() + "))";
			fs = fs + "\n (run)";
			t.append("\n \n *** 상담 결과 *** \n \n" );		
			btnRunActionPerformed(e);
		} else if (b == b2){
			t.setText(""); tf1.setText(""); tf2.setText("");
			tf3.setText(""); fs = "";} 
	    }
	}
	
	private void btnRunActionPerformed(ActionEvent e) {
		try {
			ReadJessFile readJessFile = new ReadJessFile("C:\\Users\\ckdgu\\Documents\\GitHub\\JESS_consulting\\src\\Consult.clp");
			String strTemp = readJessFile.getJessFileContent();		
			
			if (strTemp.substring(0, 1).equals("1")) {  // 0번째 첫 문자열 
				this.engine = new Rete();
				TextAreaWriter taw = new TextAreaWriter(t);
				engine.addOutputRouter("t", taw);
				strTemp = strTemp + fs;
				this.engine.executeCommand(strTemp.substring(1)); 
                                                    // 1번째부터 전체 문자열, 자바에서 Jess 실행 
			}		
		} catch (JessException ex) {
	                                  //	this.taTrace.append(ex.toString() + "\n");
		}	
	}
	public static void main(String [] args) {
		new InvCon();
	}
}
