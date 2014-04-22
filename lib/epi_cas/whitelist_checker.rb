module EpiCas
  class WhitelistChecker < Struct.new(:raw_dn, :uid)
    USER_GROUPS = {
      'ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                                 => :staff,
      'ou=honorary,ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                     => :staff_honorary,
      'ou=visiting,ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                     => :staff_visiting,
      'ou=external,ou=users,dc=sheffield,dc=ac,dc=uk'                              => :external,
      'ou=research,ou=postgraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk' => :student_pg_research,
      'ou=taught,ou=postgraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk'   => :student_pg_taught,
      'ou=undergraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk'            => :student_undergraduate
    } 
  
    def allow_authentication?
      username_whitelisted? || groups_allowed_to_log_in.member?(group)
    end
  
    def allow_creation?
      username_whitelisted? || groups_allowed_to_be_created.member?(group)
    end
  
    private
      def groups_allowed_to_log_in(setting_class = EpiCas::Settings)
        @groups_allowed_to_log_in ||= setting_class.groups_allowed_to_log_in.to_a.map(&:to_sym)
      end
      
      def groups_allowed_to_be_created(setting_class = EpiCas::Settings)
        @groups_allowed_to_be_created ||= setting_class.groups_allowed_to_be_created.to_a.map(&:to_sym)
      end
      
      def username_whitelisted?(setting_class = EpiCas::Settings)
        (setting_class.username_whitelist || []).member? uid.to_s.downcase
      end
      
      def group
        USER_GROUPS[dn]
      end
  
      def dn
        @dn ||= raw_dn[/ou=.*dc=uk/].to_s.downcase
      end
  end
end