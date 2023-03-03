import java.time.LocalDate;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class Res implements Comparable<Res> {
	
	public enum Sexo {
		H, M
	}
	
	public enum TipoRaza {
		COMUN, SHINY, ENORME, MINI, ALBINO, SINPELO
	}
	
	public enum TipoRes {
		OVINO, BOVINO, CAPRINO, PORCINO
	}
	
	Integer num_control;
	TipoRes especie;
	String raza;
	Sexo sexo;
	Integer peso;
	LocalDate fechaN;
	Integer res_madre;
	Integer res_padre;
	Integer granja_actual;
	Integer granja_nacimiento;
	
	public static final int NUM_GRANJAS=7;
	public static final int NUM_RESES=200;
	public static final int PESO_MIN=20;
	public static final int PESO_MAX_DIFF=100;
	
	
	public Res(int num_control) {
		this.num_control = num_control;
		especie = TipoRes.values()[(int) (Math.random()*(TipoRes.values()).length)];
		raza = especie.name().toLowerCase() + " " + TipoRaza.values()[(int) (Math.random()*(TipoRaza.values()).length)].name().toLowerCase();
		sexo = Sexo.values()[(int) (Math.random()*(Sexo.values()).length)];
		peso = (int) (Math.random()*100 + 20);
		fechaN = LocalDate.of((int) (Math.random()*10 + 2005), (int) (Math.random()*12 + 1), (int) (Math.random()*28 + 1));
		granja_actual = (int) (Math.random()*7+1);
	}
	
	public Res(int num_control, int madre, int padre, int granja) {
		this(num_control);
		fechaN = LocalDate.of((int) (Math.random()*7 + 2015), (int) (Math.random()*12 + 1), (int) (Math.random()*28 + 1));
		this.res_madre = madre;
		this.res_padre = padre;
		this.granja_nacimiento = granja;
	}
	
	
	
	public Integer getNum_control() {
		return num_control;
	}

	public TipoRes getEspecie() {
		return especie;
	}

	public String getRaza() {
		return raza;
	}

	public Sexo getSexo() {
		return sexo;
	}

	public Integer getPeso() {
		return peso;
	}

	public LocalDate getFechaN() {
		return fechaN;
	}

	public Integer getRes_madre() {
		return res_madre;
	}

	public Integer getRes_padre() {
		return res_padre;
	}

	public Integer getGranja_actual() {
		return granja_actual;
	}

	public Integer getGranja_nacimiento() {
		return granja_nacimiento;
	}

	@Override
	public String toString() {
		return "(" + num_control + ", \"" + especie.name().toLowerCase() + "\", \"" + raza + "\", \"" + sexo.name() + "\", " + peso + ", \"" + fechaN
				+ "\", " + res_madre + ", " + res_padre + ", " + granja_nacimiento + ", "+ granja_actual + "),";
	}
	
	
	public static boolean diferenteSexo(Res r1, Res r2) {
		return r1.getSexo().equals(r2.getSexo());
	}
	
	public static boolean mismaGranja(Res r1, Res r2) {
		return r1.getGranja_actual().equals(r2.getGranja_actual());
	}
	
	public static Res getRes(int num, Set<Res> c) {
		for (Res res : c) {
			if (res.getNum_control() == num)
				return res;
		}
		return null;
	}
	
	
	@Override
	public int hashCode() {
		return Objects.hash(num_control);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Res other = (Res) obj;
		return Objects.equals(num_control, other.num_control);
	}
	
	@Override
	public int compareTo(Res o) {
		return num_control.compareTo(o.num_control);
	}

	public static void main(String[] args) {
		Set<Res> reses = new HashSet<>();
		Set<Res> reses_hijas = new HashSet<>();
		for (int i = 0; i < NUM_RESES; i++) {
			reses.add(new Res(i+1));
		}
		int control = NUM_RESES;
		while (control < 2*NUM_RESES) {
			int c1 = (int) (Math.random()*NUM_RESES);
			int c2 = (int) (Math.random()*NUM_RESES);
			Res r1 = Res.getRes(c1+1, reses);
			Res r2 = Res.getRes(c2+1, reses);
			if (Res.diferenteSexo(r1, r2) && Res.mismaGranja(r1, r2))
				if (r1.getSexo().equals(Sexo.H))
					reses_hijas.add(new Res(++control, c1+1, c2+1, r1.granja_actual));
				else
					reses_hijas.add(new Res(++control, c2+1, c1+1, r1.granja_actual));
		}
		reses.addAll(reses_hijas);
		for (Res res : reses) {
			System.out.println(res);
		}
	}
}