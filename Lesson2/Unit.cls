public class Unit {
    private String name;
    private Integer hp;
    private Integer dmgMin;
    private Integer dmgMax;
    private Integer dmg;
    private boolean canBeResurrected; // future ability
    private Integer armor;  // future ability

    public Unit() {
    }

    public Unit(String name, Integer hp, Integer dmgMin, Integer dmgMax, boolean canBeResurrected) {
        this.name = name;
        this.hp = hp;
        this.dmgMin = dmgMin;
        this.dmgMax = dmgMax;
        this.canBeResurrected = canBeResurrected;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getHp() {
        return hp;
    }

    public void setHp(Integer hp) {
        this.hp = hp;
    }

    public Integer getDmgMin() {
        return dmgMin;
    }

    public void setDmgMin(Integer dmgMin) {
        this.dmgMin = dmgMin;
    }

    public Integer getDmgMax() {
        return dmgMax;
    }

    public void setDmgMax(Integer dmgMax) {
        this.dmgMax = dmgMax;
    }

    public boolean isCanBeResurrected() {
        return canBeResurrected;
    }

    public void setCanBeResurrected(boolean canBeResurrected) {
        this.canBeResurrected = canBeResurrected;
    }

    public Integer getDmg() {
        return dmg;
    }

    public void setDmg(Integer dmg) {
        this.dmg = dmg;
    }  
}